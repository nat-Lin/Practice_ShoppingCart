class ApplicationController < ActionController::Base
	include CartsHelper

  private
    def gateway
      gateway = Braintree::Gateway.new(
        :environment => :sandbox,
        :merchant_id => 't3ncnqmhfm24qdmp',
        :public_key => 'kgtp5f9sgcrsdxmh',
        :private_key => '6e99ff2b3611bbee563320aa91b22b25',
      )
    end
end
