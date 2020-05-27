class ReportUtils
  def self.get_screenshot(browser)
    fullpath = "#{Dir.getwd}/testreport/reports/screenshots/screenshot#{Time.now.strftime("%Y_%m_%d-%HH_%MM_%SS")}.png"
    screenshotpath = fullpath.gsub("#{Dir.getwd}/testreport/reports", ".")
    sleep 1
    browser.save_screenshot fullpath
    screenshotpath
  end

  private

  def self.insert_example_values_into_step(step, examples)
    step_holders = step.scan(/<\w*\S*>/).to_a
    if step_holders.size != 0
      for i in 0..step_holders.size - 1
        step = step.gsub(step_holders[i].to_s, examples[step_holders[i].gsub("<", "").gsub(">", "")].to_s)
      end
    end
    return step
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
    if feature_.class.to_s == "Cucumber::RunningTestCase::ScenarioOutlineExample"
      # match scenario
      feature_.feature.feature_elements.size.times do |z|
        if feature_.feature.feature_elements[z].to_s == scenario.name.gsub(/, Examples \(#\d*\)/, "")
          @outline_examples = feature_.feature.feature_elements[z].examples_tables[0].example_rows.to_s.scan(/{([^}]*)/)
          for i in 1..feature_.scenario_outline.step_count.to_i
            step = feature_.feature.feature_elements[z].steps[i - 1]
            example_values = eval("{+#{@outline_examples[$examples_count][0]}}")
            arr_steps << insert_example_values_into_step(step.to_s, example_values)
          end
          break
        end
      end
      reset_examples_counter(@outline_examples)
    else
      # match scenario
      feature_.feature_elements.size.times do |z|
        if feature_.feature_elements[z].to_s == scenario.name.to_s
          feature_.feature_elements[z].children.each do |step|
            arr_steps << step
          end
        end
      end
    end
    arr_steps
  end

  def self.output_tag(scenario, extent_test)
    scenario.source_tag_names.each do |tag|
      if tag.include? "SLO-"
        extent_test.assign_category($obj_env_yml["jira_url"] + tag.to_s.tr('@"[]]', ""))
      else
        extent_test.assign_category(tag.to_s.tr('@"[]]', ""))
      end
    end
  end

  def self.make_folder(folder_name)
    Dir.mkdir("testreport/#{folder_name}")
    Dir["testreport/*"].each do |subfolder|
      FileUtils.cp_r(subfolder, "testreport/#{folder_name}/") unless subfolder.to_s.include? "@"
      FileUtils.cp_r(subfolder, "testreport/#{folder_name}/") if ["jsonreports", "log", "reports", "xmlreports"].include? subfolder.to_s
    end
  end

  def self.clear_folder
    Dir["testreport/*"].each do |subfolder|
      FileUtils.rm_r(subfolder) if ["jsonreports", "log", "reports", "xmlreports"].include? subfolder.to_s
      FileUtils.rm_r(subfolder) unless subfolder.to_s.include? "@"
    end
  end

  # ##return list of steps with example variables
  # def self.get_steps_for_examples(file)
  #   report = File.read(file)
  #   data = JSON.parse(report)
  #   @overall_steps = []
  #   # CSV.open("xls/AllScenarioSteps.csv", "a+") do |csv|
  #   #   data[0]['elements'].each do |element|
  #   #     @scenario_steps = []
  #   #     element['steps'].each do |steps|
  #   #       @scenario_steps << steps['name']
  #   #     end
  #   #     @overall_steps << @scenario_steps
  #   #     csv << @scenario_steps
  #   #   end
  #   # end
  #   # @overall_steps
  # end

end
