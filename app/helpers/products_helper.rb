module ProductsHelper
  def categories 
    I18n.t(:categories).map { |key, value| [ value, key.to_s ] } 
  end 
end
