fs  = require 'fs'

read_integer = (array_f) ->
    num_str = fs.readFileSync(array_f,'utf8')
    num_str_l = num_str.match /^(\d+)/mg
    num_l = ( Number(u_num) for u_num in num_str_l)

merge_count = (num_1_l,num_2_l) ->
    merge_l = []
    n_total = num_1_l.length + num_2_l.length
    i_1 = 0
    i_2 = 0
    ct_inversion = 0
    for i_num in [0...n_total]
        if num_1_l[i_1] < num_2_l[i_2]
            merge_l.push num_1_l[i_1]
            i_1 = i_1 + 1
            if i_1 > (num_1_l.length - 1)
                merge_l = merge_l.concat num_2_l[i_2..]
                break
        else
            merge_l.push num_2_l[i_2]
            i_2 = i_2 + 1
            ct_inversion = ct_inversion + num_1_l.length - i_1
            if i_2 > (num_2_l.length - 1)
                merge_l = merge_l.concat num_1_l[i_1..]
                break
            
    [merge_l, ct_inversion]

sort_count = (num_l) ->
    if num_l.length == 2
        if num_l[0] < num_l[1]
            return [num_l, 0]
        else
            num_l = [num_l[1],num_l[0]]
            return [num_l, 1]
    if num_l.length == 1
        return [num_l, 0]
        
    if num_l.length > 2
        i_split = Math.floor(num_l.length/2)
        num_1_l = num_l[...i_split]
        num_2_l = num_l[i_split..]
        
        [sorted_1_l, n_inversion_1] = sort_count num_1_l
        [sorted_2_l, n_inversion_2] = sort_count num_2_l
        
        #console.log num_1_l,num_2_l,sorted_1_l,sorted_2_l
        [merge_l, n_inversion_12] = merge_count(sorted_1_l,sorted_2_l)
        n_inversion_total = n_inversion_1 + n_inversion_2 + n_inversion_12
        return [merge_l, n_inversion_total]
    
main = () ->
    num_l = read_integer 'IntegerArray.txt'
    [sorted_l,ct_inversion] = sort_count num_l
    console.log ct_inversion
    console.log sorted_l[...10]
    console.log sorted_l[9000...9010]
    
main()
#num_l = read_integer 'IntegerArray.txt'
#console.log num_l.length
#console.log num_l[..10]

#console.log merge_count([3,4,5],[1,2,6])
#console.log merge_count([1,3,5],[2,4,6])

#console.log sort_count([3,4,1,2,5,6])
    