module BrowserActions

  def scroll_down(dist, browser)
    browser.execute_script("window.scrollBy(0,#{dist})")
  end

  def scroll_and_click(e, browser='')
    begin
      e.click
    rescue
      scroll_down(300,@browser)
      e.click
    end
  end

  def wait_for_element(element, message="Element not clickable",timeout=200)
    wait=0
    timeout.times do
      sleep 1
      begin
        break if element.visible?
      rescue Exception => e
        p "checking for Element visibility"
      end
      wait+=1
    end
    if wait>=timeout 
      return false 
    else 
      return true
    end
  end

  def wait_for_element_to_disappear(element, message="Element not disappeared", timeout=180)
    wait=0
    timeout.to_i.times do
      sleep 1
      begin
        break unless element.visible?
        wait+=1
      rescue
        sleep 1
        break
      end
    end
    raise "#{message}" if wait>=timeout
  end

  def perform_action(element, browser)
    WebElement x = browser.execute_script("return window.getComputedStyle(arguments[0], ':before').getPropertyValue('background-color');", element)
    x.click
  end

  def click_menu_element(elements,which_menu)
      elements.each do |element|
        return element if element.text.downcase == which_menu.downcase
      end
  end

end