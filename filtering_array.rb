# Solution 17/04/2023
# Note: Products are sorted by price, so you can avoid to iterate all the array
def filter_products(products, queries)
  results = []

  queries.each do |q|
    type = q[0]
    value = q[1]

    # Apply query to products
    if type == "Type1"
      filtered_products = products.filter {|p| p[2] == value}
    elsif type == "Type2"
      filtered_products = products.filter {|p| p[1].to_i < value.to_i}
    else #type == "Type3"
      filtered_products = products.filter {|p| p[1].to_i > value.to_i}
    end

    results.append(filtered_products.map{|p| p[0]})
  end

  results
end


# #Uncomment if is necessary:
# ########################################       Parsing     ########################################
# # I add this parsing methods to change the indexes easily, in case they do not match the indices of the original problem.
#
# require "ostruct"
#
# def parse_product(product)
#   p =  OpenStruct.new
#   p.name = product[0]
#   p.price = product[1].to_i  #Change this index if is necessary
#   p.year = product[2].to_i   #Change this index if is necessary
#
#   p
# end
#
# def parse_query(query)
#   q =  OpenStruct.new
#   q.type = query[0]
#   q.value = query[1].to_i
#
#   q
# end
#
# def filter_products(products, queries)
#   products = products.map {|p| parse_product(p)}
#   queries = queries.map {|q| parse_query(q)}
#   results = []
#
#   queries.each do |q|
#     # Apply query to products
#     if q.type == "Type1"
#       filtered_products = products.filter {|p| p.year == q.value}
#     elsif q.type == "Type2"
#       filtered_products = products.filter {|p| p.price < q.value}
#     else #type == "Type3"
#       filtered_products = products.filter {|p| p.price > q.value}
#     end
#
#     results.append(filtered_products.map{|p| p.name})
#   end
#
#   results
# end
