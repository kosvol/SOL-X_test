class SeleniumUtil

    # def self.find_element_by_class_name(name)
    #     $browser.find_element(:name,name)
    # end

    def self.find_element_by_name_exists(name)
        begin
            $browser.find_element(:name,name)
            return true
        rescue
            return false
        end
    end

    def self.find_element_by_id(id)
        $browser.find_element(:id,id)
    end

    def self.find_elements_by_xpath(xpath)
        $browser.find_elements(:xpath,xpath)
    end

    def self.find_element_by_xpath(xpath)
        $browser.find_element(:xpath,xpath)
    end

    def self.find_element_by_xpath_exists(xpath)
        begin
                $browser.find_element(:xpath,xpath)
                return true
        rescue
                return false
        end
    end

    # def self.click(element)
    #     sleep 1
    #     element.click
    # end

    # def self.enter(element,input)
    #     element.send_keys(input)
    #     $browser.hide_keyboard if $current_platform != "mobilewebsite"
    # end

    # def self.clear(element)
    #     element.clear
    # end

    # def self.get_text(element)
    #     element.text.strip
    # end

    # def get_arr_of_texts(elements)
    #     arr = []
    #     elements.each do |element|
    #             arr << element.text
    #     end
    #     return arr
    # end

    ###  Web
    def self.find_web_element_by_css_exists(identifier)
        begin
                $browser.find_element(:css, identifier)
                return true
        rescue
                return false
        end
    end

    def self.find_web_element_by_css(identifier)
        $browser.find_element(:css, identifier)
    end

    def self.find_web_elements_by_css(identifier)
        $browser.find_elements(:css, identifier)
    end

    # def self.tap(x_value,y_value,element=nil)
    #     $browser.execute_script('mobile: tap', x: x_value, y: y_value, element: element)
    # end

    # def self.swipe(direction)
    #     $browser.execute_script('mobile: swipe', direction: direction)
    # end

    # def self.scroll(direction)
    #     $browser.execute_script('mobile: scroll', direction: direction)
    # end

    # def self.scroll1(direction,elem)
    #     $browser.execute_script('mobile: scroll', direction: direction,element: elem.ref)
    # end

    # def self.double_tap(element1)
    #     Appium::TouchAction.new($browser).tap(element: element1).perform
    #     Appium::TouchAction.new($browser).tap(element: element1).perform
    # end
end