# frozen_string_literal: true

require 'cucumber/formatter/html'

module Formatter
  class HtmlFormatter < Cucumber::Formatter::Html
    def before_features(features)
      @step_count = features&.step_count || 0 # TODO: Make this work with core!

      # <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      @builder.declare!
      @builder << '<html xmlns ="http://www.w3.org/1999/xhtml">'
      @builder.head do
        @builder.meta('http-equiv' => 'Content-Type', :content => 'text/html;charset=utf-8')
        @builder.title 'Cucumber'
      end
      @builder << '<body>'
      @builder << "<!-- Step count #{@step_count}-->"
      @builder << '<div class="cucumber">'
      @builder.div(id: 'cucumber-header') do
        @builder.div(id: 'label') do
          @builder.h1('Cucumber Features')
        end
        @builder.div(id: 'summary') do
          @builder.p('', id: 'totals')
          @builder.p('', id: 'duration')
          @builder.div(id: 'expand-collapse') do
            @builder.p('Expand All', id: 'expander')
            @builder.p('Collapse All', id: 'collapser')
          end
        end
      end
      $tables = []
    end

    def embed(str_src, str_mime_type, str_label)
      case str_mime_type
      when %r{^image/(png|gif|jpg|jpeg)}
        embed_image(str_src, str_label)
      when %r{^text/plain}
        embed_file(str_src, str_label)
      else
        raise "Wrong type >>> #{str_mime_type}"
      end
    end

    def embed_link(str_src, str_label)
      @builder.span(class: 'embed') do |pre|
        pre << %(<a href="#{str_src}" target="_blank">"#{str_label}"</a> )
      end
    end

    def embed_file(str_src, str_label = 'Click to view embedded file')
      id = "object_#{Time.now.strftime('%y%m%d%H%M%S')}"
      @builder.span(class: 'embed') do |pre|
        pre << %{<a href="" onclick="o=document.getElementById('#{id}');
          o.style.display = (o.style.display == 'none' ? 'block' : 'none');
          return false">#{str_label}</a><br>&nbsp;
	        <object id="#{id}" data="#{str_src}" type="text/plain" width="100%" style="height: 10em;
          display: none"></object>}
      end
    end

    def before_table_row(table_row)
      $value = []
      @row_id = table_row.dom_id
      @col_index = 0
      return if @hide_this_step

      @builder << "<tr class='step' id='#{@row_id}'>"
    end

    def after_table_row(table_row)
      return if @hide_this_step

      print_table_row_messages
      @builder << '</tr>'
      if table_row.exception
        @builder.tr do
          @builder.td(colspan: @col_index.to_s, class: 'failed') do
            @builder.pre do |pre|
              pre << h(format_exception(table_row.exception))
            end
          end
        end
        if table_row.exception.is_a? ::Cucumber::Pending
          set_scenario_color_pending
        else
          set_scenario_color_failed
        end
      end
      @outline_row += 1 if @outline_row
      @step_number += 1
      move_progress
      if @outline_row == 1
        @first = $value
      else
        $table = '('
        $value.size.times do |i|
          $table += "| #{@first[i]}: #{$value[i]} " if @first
        end
        $table += '|))'
        $tables << $table
      end
    end

    def table_cell_value(value, status)
      return if @hide_this_step

      $value << value

      @cell_type = @outline_row.zero? ? :th : :td
      attributes = { id: "#{@row_id}_#{@col_index}", class: 'step' }
      attributes[:class] += " #{status}" if status
      build_cell(@cell_type, value, attributes)
      set_scenario_color(status) if @inside_outline
      @col_index += 1
    end

    def self.examples
      $tables
    end

    def after_steps(_steps)
      print_messages
      @builder << '</ol>' if @in_background || @in_scenario_outline
    end
  end
end
