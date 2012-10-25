#encoding: utf-8
module PricesHelper
  def include_all_price(shop_id, product_id)
    return_text = ''
    ShopProduct.where(shop_id: shop_id, product_id: product_id).each do |sh_pr|
      return_text += '<p><nobr><small>'
      return_text += sh_pr.name.gsub('%', 'проц.').gsub('"', '&uml;')
      return_text += ' - '
      return_text += number_to_currency(sh_pr.try(:price) || '0', unit: 'p.', separator: ',', format: "%n%u")
      return_text += '</small></nobr>'
      return_text += '</p>'
    end
    return_text
  end
end