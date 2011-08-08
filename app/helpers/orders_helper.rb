module OrdersHelper
	def pay_types
		I18n.t(:pay_types).map do |key, value|
			[value, key.to_s]
		end
	end
end
