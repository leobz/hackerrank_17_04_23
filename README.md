##  Table of Contents
- [Table of Contents](#table-of-contents)
- [Problem description](#problem-description)
- [HackerRank 17/04/2023 solution](#hackerrank-17042023-solution)
- [Little improvement](#little-improvement)
- [Unit Testing](#unit-testing)


<div id='problem_description' />

## Problem description 

**Important** : This description of the problem **may not exactly match the original statement**
since I have not found it on the internet and it is only a reconstruction of it.


`filter_products()` receives 2 parameters:

- `products`: Two-dimensional array [p1,p2,pn] / pi = [name, price, year]
- `queries`: Two-dimensional array [q1, q2, qn] / qi = [type, value]
  - `type` can be:
    - "Type1" -> year equal to value
    - "Type2" -> Price less than value
    - "Type3" -> Price greater than value


`filter_products()` returns:
- `results`: Two-dimensional array [r1,r2,rn] / ri = qi(products). qi(products)

**Note**: Prices are sorted in ascending order


<div id='hackerrank_solution' />

## HackerRank 17/04/2023 solution

```ruby
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
```

<div id='improvment' />

## Little improvement 

A little improvement which I couldn't add in the tests for time reasons. Using a binary search, we can avoid iterating all the arrays (since prices are sorted in ascending order.)

```ruby
def filter_products(products, queries)
  results = []

  queries.each do |q|
    type = q[0]
    value = q[1]

    # Apply query to products
    if type == "Type1"
      filtered_products = products.filter {|p| p[2] == value}
    elsif type == "Type2"
      index = products.bsearch_index {|p| p[1].to_i >= value.to_i}
      filtered_products = index ? products.slice(0, index) : []
    else #type == "Type3"
      index = products.bsearch_index {|p| p[1].to_i > value.to_i}
      filtered_products = index ? products.slice(index, products.length - 1) : []
    end

    results.append(filtered_products.map{|p| p[0]})
  end

  results
end

```


## Unit Testing

In this repository there are 2 files, `filtering_array.rb` which has the definition of the method and `test.rb` which I used to do `TDD`.

You can run it with

- `gem install rspec` 
- `rspec test.rb`