#Viveum-Ogone for Rails


##What is it

A Ruby gem to simplify the use of [Ogone](http://www.ogone.com) online payments service as offered by Viveum.


##Usage

### Installation
	gem install ogone-rails

### Configuration
Define:

* PSPID
* sha_in
* sha_out
* currency | default: "EUR"
* language | default: "nl_NL"
* test | default = "live"



		# config/initializers/ogone-rails.rb
		
		OgoneRails::config ({
		  :pspid => "myPSPID",
		  :sha_in => "0123456789abcdefghijklmnopqrstuv",
		  :sha_out => "vutsrqponmlkjihgfedcba9876543210",
		  :mode => "test""
		})



### Helpers
Generate an **ogone_form**:

	ogone_form({
		#transaction information
    	:order_id => 12345, 
    	:amount => 299.99, 
    	:customer_name => "Jan Janssen",
    	:customer_email => "jan@email.com",
   		:customer_address => "highstreet 101",
   		:customer_zip => "1000",
    	:customer_city => "Brussel",
    	:customer_country => "Belgium",
    	:customer_phone => "0412345678",
    	
    	# feedback url's
    	:accept_url => "www.example.com/ogone/accept",
    	:decline_url => "www.example.com/ogone/decline",
    	:exception_url => "www.example.com/ogone/exception",
    	:cancel_url => "www.example.com/ogone/cancel",
    	
    	# look and feel
    	:title => "lorem ipsum",
    	:bg_color => "FFFFFF",
    	:text_color => "000000",
    	:table_bg_color => "000000",
    	:table_text_color => "000000",    	
    	:button_bg_color => "CCCCCC",
    	:button_text_color => "000000",
    	:font_family => "Helvetica",
    	:logo => "www.example.com/images/logo.png",
    	
    	# default ogone parameter
    	'PARAM' => "example"
   	})

### Check Ogone feedback

Create a new object to check the feedback Ogone gives you:

	# app/controllers/feedback_controller.rb
    @check = OgoneRails::CheckAuth.new( request )

Check valid authorization:
	
	@check.valid?
	#return true or false

Get parameters:
	
	@check.get_parameters
	
… returns the Ogone feedback in a hash format. The keys are made more readable then Ogone provides them: …

	{
		"order_id" => 46185, 
		"amount" => 299.38, 
		"currency" => "EUR", 
		"payment_method" => "CreditCard",
		"acceptance" => "test123", 
		"status" => "Authorized", 
		"card_number" => "XXXXXXXXXXXX1111",
		"pay_id" => "14838904", 
		"error" => nil, 
		"brand" => "VISA",
		"sha_sign" => "51AF71351E79DD0186816289AD53C57213978E32"
	}
	
### Copyright
Copyright &copy; 2012 Robin Houdmeyers