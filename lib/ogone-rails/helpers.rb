module OgoneRails

  module Helpers
    extend self

    def ogone_form options={}
      
      OgoneRails::mode == "live" ? action = OgoneRails::LIVE_SERVICE_URL : action = OgoneRails::TEST_SERVICE_URL
      
      form = Form.new(action)
      hash = StringToHash.new
      
      # REQUIRED VALUES
      # hash.reset
      # pspid
      form.add_input('PSPID', OgoneRails::pspid)
      hash.add_parameter 'PSPID', OgoneRails::pspid
      # language
      form.add_input('language', OgoneRails::language)
      hash.add_parameter 'language', OgoneRails::language
      
      
      
      # OPTIONAL VALUES
      options.each do |option, value|
        case option
        
        
        # ------------------
        # General parameters
        
        when :order_id
          form.add_input('orderID', value)
          hash.add_parameter 'orderID', value
          
        when :amount
          #amount 15.00 -> 1500
          value = (value.to_f * 100).to_i
          form.add_input('amount', value)
          hash.add_parameter 'amount', value
          
        when :customer_name
          form.add_input('CN', value)
          hash.add_parameter 'CN', value
          
        when :customer_email
          form.add_input('EMAIL', value)
          hash.add_parameter 'EMAIL', value
          
        when :customer_address
          form.add_input('owneraddress', value)
          hash.add_parameter 'owneraddress', value
          
        when :customer_zip
          form.add_input('ownerZIP', value)
          hash.add_parameter 'ownerZIP', value
          
        when :customer_city
          form.add_input('ownertown', value)
          hash.add_parameter 'ownertown', value
          
        when :customer_country
          form.add_input('ownercty', value)
          hash.add_parameter 'ownercty', value
          
        when :customer_phone
          form.add_input('ownertelno', value)
          hash.add_parameter 'ownertelno', value
        
        
        # --------------
        # Feedback url's
        
        when :accept_url
          form.add_input('accepturl', value)
          hash.add_parameter 'accepturl', value
          
        when :decline_url
          form.add_input('declineurl', value)
          hash.add_parameter 'declineurl', value
        
        when :exception_url
          form.add_input('exceptionurl', value)
          hash.add_parameter 'exceptionurl', value
          
        when :cancel_url
          form.add_input('cancelurl', value)
          hash.add_parameter 'cancelurl', value
        
        
        # --------------
        # Look and feel
        
        when :title
          form.add_input('TITLE', value)
          hash.add_parameter 'TITLE', value

        when :bg_color
          form.add_input('BGCOLOR', value)
          hash.add_parameter 'BGCOLOR', value


        when :text_color
          form.add_input('TXTCOLOR', value)
          hash.add_parameter 'TXTCOLOR', value


        when :table_bg_color
          form.add_input('TBLBGCOLOR', value)
          hash.add_parameter 'TBLBGCOLOR', value

        when :table_text_color
          form.add_input('TBLTXTCOLOR', value)
          hash.add_parameter 'TBLTXTCOLOR', value
        
        
        when :button_bg_color
          form.add_input('BUTTONBGCOLOR', value)
          hash.add_parameter 'BUTTONBGCOLOR', value
        
        
        when :button_text_color
          form.add_input('BUTTONTXTCOLOR', value)
          hash.add_parameter 'BUTTONTXTCOLOR', value
        
        
        when :font_family
          form.add_input('FONTTYPE', value)
          hash.add_parameter 'FONTTYPE', value
        
        when :logo
          form.add_input('LOGO', value)
          hash.add_parameter 'LOGO', value
        
        
        else
          form.add_input(option, value)
          hash.add_parameter(option, value)
        end
      end
      
      # shasign
      sha_in = hash.generate_sha_in
      form.add_input('sha_phrase', hash.sha_in_phrase)
      
      form.add_input('SHASign', sha_in)

      form.get_form
    end
  end
  
  
  private
  
    class Form
      def initialize action
        @form = ""
        @form << "<form method='post' action='#{action}'>\n"
      end
    
      def add_input name, value
        @form << "\t<input type='hidden' name='#{name}' value='#{value}'>\n"
      end

    
      def get_form
        @form << "\t<button type='submit' class='btn btn-primary btn-large' id='submit2' name='submit2'>#{I18n.t(:"ogone.submit")}</button>\n"
        @form << "</form>"
        @form.html_safe
      end
    end
end