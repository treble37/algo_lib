module QuickSort
  #7/19/12 Weds, a recursive implementation of the famous QuickSort algorithm
  
  def choosepivot(a,p)
    if p<a.length
      return a[p] #choose first pivot by default
    else
      return -1 #out of range
    end
  end
  def partition(a,l,r)
    #return partitioned array, pivot position
    @i=l+1
    @j=l+1
    @pivot = a[l] #assume first element
    while @j<=r
      if a[@j]<@pivot
        temp = a[@j]  #swap
        a[@j]=a[@i]
        a[@i] = temp
        @i=@i+1
      end
      @j=@j+1
    end #end while
    #swap a[l] (pivot) and a[@i-1]
    a[l],a[@i-1] = a[@i-1], a[l]
    # temp = a[l]
    # a[l] = a[@i-1]
    # a[@i-1] = temp
    return a,@i-1
  end
  def swap_array_elements(a,l,r)
    a[l],a[r]=a[r],a[l]
    return a
  end
  def median_three(a,b,c)
    #return the median of a,b,c
    [a,b,c].sort[1]
  end
  def array_middle(a)
    #return the middle element of an array and index of position
    if a.length%2==0
      return a[(a.length-1)/2],(a.length-1)/2
    else
      return a[a.length/2],a.length/2
    end
  end
  def quicksort(a,n,comparison_count, pivot_switch)
    if n==1 
      return a, comparison_count
    end
    
    
    #if pivot not first element, swap as preprocessing step
    case pivot_switch
    when 2
    ##CASE 2:  Use pivot as last element
      p=choosepivot(a,a.length-1) #choose pivot as last element
      a=swap_array_elements(a,0,a.length-1)
    when 3
    ##CASE 3:  Use median of 3 pivot rule
      a_first = a.first
      a_mid,mid_pos = array_middle(a)
      a_last = a.last
      p=median_three(a_first,a_mid,a_last)
      median_pos = a.index(p)
      a=swap_array_elements(a,0,median_pos)
    else
      ##CASE 1, all others: choose pivot as first element
      p=choosepivot(a,0) 
    end
    
    new_a,pivot_pos = partition(a,0,a.length-1) #pivot now in correct position
    #puts "left call: "+" pivot_pos "+pivot_pos.to_s
    # if new_a.length>=2
      # puts new_a.to_s
      # puts "len "+new_a.length.to_s
      # puts "piv "+pivot_pos.to_s
      # puts "count "+comparison_count.to_s
      # puts ""
    # end
    leftcount=0
    rightcount=0
    # puts comparison_count
    # puts ""
    #puts pivot_pos.to_s
    #puts new_a.to_s
    case pivot_pos
    when 0
   #   puts "right "+new_a[pivot_pos+1..new_a.length-1].to_s+" incount "+(new_a.length-(pivot_pos+1)).to_s+" rcount "+rightcount.to_s
      b=nil
      c,rightcount=quicksort(new_a[pivot_pos+1..new_a.length-1],new_a[pivot_pos+1..new_a.length-1].length,new_a.length-(pivot_pos+1),pivot_switch)
      #puts " rcount "+rightcount.to_s
    when a.length-1
    #  puts "left "+new_a[0..pivot_pos-1].to_s+" incount "+pivot_pos.to_s+" lcount "+leftcount.to_s
      b,leftcount=quicksort(new_a[0..pivot_pos-1],new_a[0..pivot_pos-1].length,pivot_pos,pivot_switch) #recursively sort 1st part
      c=nil
      #puts " lcount "+leftcount.to_s
    else
     # puts "left+right "+new_a[0..pivot_pos-1].to_s+"+"+new_a[pivot_pos+1..new_a.length-1].to_s
      count1 = (pivot_pos-1)+1
      count2 = new_a.length-(pivot_pos+1)   
      b,leftcount=quicksort(new_a[0..pivot_pos-1],new_a[0..pivot_pos-1].length,count1,pivot_switch) #recursively sort 1st part
      c,rightcount=quicksort(new_a[pivot_pos+1..new_a.length-1],new_a[pivot_pos+1..new_a.length-1].length,count2,pivot_switch) #recursively sort 2nd part
      
     # puts "leftcount+rightcount "+leftcount.to_s+"+"+rightcount.to_s
     # puts "count1+count2 "+count1.to_s+"+"+count2.to_s
    end
    comparison_count = comparison_count+leftcount+rightcount
    #puts "left+right="+leftcount.to_s+"+"+rightcount.to_s+"="+"comp count "+comparison_count.to_s
    d=[b,p,c].flatten.compact
    return d,comparison_count
  end
end #QuickSort module

#first initialize array from file
@my_arr = IO.readlines("QuickSort.txt")
@my_arr.length.times do |x|
  @my_arr[x]=@my_arr[x].chop #Returns a new String with the last character removed. If the string ends with \r\n, both characters are removed. 
  @my_arr[x]=@my_arr[x].to_i #Convert to integer
end
# ar=[4,3,1,5,7,6]
 # b,count=quicksort(ar,ar.length,0)
 # puts "count:" +count.to_s
@a,count = quicksort(@my_arr,@my_arr.length,0)
puts count
# File.open('output.txt', 'w') do |file|
  # file.puts @a.each { |x| }
# end

