# frozen_string_literal: true

class ReportUtils
  def self.get_screenshot(browser)
    fullpath = "#{Dir.getwd}/testreport/reports/screenshots/screenshot#{Time.now.strftime('%Y_%m_%d-%HH_%MM_%SS')}.png"
    screenshotpath = fullpath.gsub("#{Dir.getwd}/testreport/reports", '.')
    sleep 1
    browser.save_screenshot fullpath
    screenshotpath
  end

  private

  def self.insert_example_values_into_step(step, examples)
    step_holders = step.scan(/<\w*\S*>/).to_a
    unless step_holders.empty?
      (0..step_holders.size - 1).each do |i|
        step = step.gsub(step_holders[i].to_s, examples[step_holders[i].gsub('<', '').gsub('>', '')].to_s)
      end
    end
    step
  end

  private

  def self.reset_examples_counter(outline_examples)
    if $examples_count != outline_examples.size - 1
      $examples_count += 1
    else
      $examples_count = 0
    end
  end

  def self.get_steps(feature_, scenario)
    arr_steps = []
    if feature_.class.to_s == 'Cucumber::RunningTestCase::ScenarioOutlineExample'
      # match scenario
      feature_.feature.feature_elements.size.times do |z|
        unless feature_.feature.feature_elements[z].to_s == scenario.name.gsub(/, Examples \(#\d*\)/, '')
          next
        end

        @outline_examples = feature_.feature.feature_elements[z].examples_tables[0].example_rows.to_s.scan(/{([^}]*)/)
        (1..feature_.scenario_outline.step_count.to_i).each do |i|
          step = feature_.feature.feature_elements[z].steps[i - 1]
          example_values = eval("{+#{@outline_examples[$examples_count][0]}}")
          arr_steps << insert_example_values_into_step(step.to_s, example_values)
        end
        break
      end
      reset_examples_counter(@outline_examples)
    else
      # match scenario
      feature_.feature_elements.size.times do |z|
        next unless feature_.feature_elements[z].to_s == scenario.name.to_s

        feature_.feature_elements[z].children.each do |step|
          arr_steps << step
        end
      end
    end
    arr_steps
  end

  def self.output_tag(scenario, extent_test)
    scenario.source_tag_names.each do |tag|
      if tag.include? 'SOL-'
        extent_test.assign_category($obj_env_yml['jira_url'] + tag.to_s.tr('@"[]]', ''))
      else
        extent_test.assign_category(tag.to_s.tr('@"[]]', ''))
      end
    end
  end

  def self.make_folder_test(folder_name)
    Dir.mkdir("testreport/#{folder_name}")
    Dir['testreport/*'].each do |subfolder|
      if %w[testreport/css testreport/log testreport/reports testreport/img].include? subfolder.to_s
        FileUtils.cp_r(subfolder, "testreport/#{folder_name}/")
      end
    end
  end

  def self.make_folder_documentation(folder_name)
    Dir.mkdir("testreport/#{folder_name}")
    Dir['testreport/*'].each do |subfolder|
      if %w[testreport/css testreport/img testreport/livingdoc].include? subfolder.to_s
        FileUtils.cp_r(subfolder, "testreport/#{folder_name}/")
      end
    end
    FileUtils.cp_r('testreport/reports/screenshots/', "testreport/#{folder_name}/livingdoc/")
  end

  def self.clear_folder
    Dir['testreport/*'].each do |subfolder|
      # if %w[testreport/jsonreports testreport/log testreport/reports testreport/xmlreports testreport/livingdoc].include? subfolder.to_s
      #   FileUtils.rm_r(subfolder)
      # end
      unless %w[testreport/css testreport/img].include? subfolder
        FileUtils.rm_r(subfolder)
      end
    end
  end
end
