require 'selenium/webdriver'
require_relative 'auth_data.rb'
=begin
		auth_data.rb has two virabels:
			$email="my@mail.com"
			$password="mypass"
=end

begin
	profile = Selenium::WebDriver::Firefox::Profile.new
	profile["browser.privatebrowsing.autostart"] = true
	caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)
	$driver = Selenium::WebDriver.for(:ff, :desired_capabilities => caps)
	$driver.manage().window().maximize()
rescue Exception => e
	puts e.message
	Process.exit(0)
end

# Quit the selenium driver at exit.
at_exit do
	$driver.quit()
end

$driver.get("https://www.conradelektronik.dk")
sleep(1)

hover_over = $driver.find_element(:id, "quicklogin_state")
$driver.action.move_to(hover_over).perform
sleep(0.5)

email_field = $driver.find_element(:name, "input_login_email")
email_field.clear()
email_field.send_keys($email)

pass_field = $driver.find_element(:name, "input_login_pw")
pass_field.clear()
pass_field.send_keys($password)

$driver.find_element(:xpath, "id('quicklogin')/button").click()
sleep(1)

$driver.get("https://www.conradelektronik.dk/websale8/?Ctx=%257bver%252f8%252fver%257d%257bst%252f415%252fst%257d%257bcmd%252f1%252fcmd%257d%257bm%252fwebsale%252fm%257d%257bs%252fconrad%252ddk%252fs%257d%257bl%252f02%252daa%252fl%257d%257bssl%252fx%252fssl%257d%257bmd5%252fb75ff4b9c7281af17c2bbf618ddee429%252fmd5%257d")
sleep(1)

dropdown_list = $driver.find_element(:name, "order_hist_number")
option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
options = dropdown_list.find_elements(tag_name: 'option')

options.each do |option|
	$driver.get("https://www.conradelektronik.dk/websale8/?Ctx=%257bver%252f8%252fver%257d%257bst%252f415%252fst%257d%257bcmd%252f1%252fcmd%257d%257bm%252fwebsale%252fm%257d%257bs%252fconrad%252ddk%252fs%257d%257bl%252f02%252daa%252fl%257d%257bssl%252fx%252fssl%257d%257bmd5%252fb75ff4b9c7281af17c2bbf618ddee429%252fmd5%257d")
	sleep(1)
	puts option.text
	option.click
	sleep(2)
end

sleep(1)