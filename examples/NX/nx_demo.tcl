# Autogenerated with DRAKON Editor 1.32

package require nx

#!/usr/bin/env tclsh


#Begin of class
nx::Class create nx_demo {


    :public method alt_select_test {} {
        #item 289
        :alternative_select -100 -1
        :alternative_select 100 1
        :alternative_select 0 0
    }

    :public method foreach_demo {} {
        #item 178
        puts "iteration demo"
        #item 169
        set sequence [:fibonacci 15]
        #item 170
        :print_list_arrow $sequence
        :print_list_for $sequence
        :print_list_foreach $sequence
        #item 183
        puts ""
        #item 379
        :test_early 20 60
        #item 381
        :test_early 35 70
        #item 382
        :test_early 4 0
    }

    :public method quick_sort_demo {} {
        #item 277
        puts "quick sort demo"
        #item 246
        set unsorted { the sooner we start this the better }
        set sorted { aa bb cc dd ee ff }
        set reverse { ff ee dd cc bb aa }
        set empty {}
        set flat { flat flat flat flat }
        #item 247
        set unsorted2 [:quick_sort $unsorted :string_comparer]
        set sorted2 [:quick_sort $sorted :string_comparer]
        set reverse2 [:quick_sort $reverse :string_comparer]
        set empty2 [:quick_sort $empty :string_comparer]
        set flat2 [:quick_sort $flat :string_comparer]
        #item 248
        puts $unsorted2
        puts $sorted2
        puts $reverse2
        puts $empty2
        puts $flat2
        #item 249
        :strings_are_sorted $unsorted2
        :strings_are_sorted $sorted2
        :strings_are_sorted $reverse2
        :strings_are_sorted $empty2
        :strings_are_sorted $flat2
    }

    :method alternative_select {value expected} {
        #item 2950001
        if {$value < 0} {
            #item 303
            set actual -1
        } else {
            #item 2950002
            if {$value == 0} {
                #item 304
                set actual  0
            } else {
                #item 305
                set actual 1
            }
        }
        #item 306
        if {$actual == $expected} {
            
        } else {
            #item 312
            error "alt select failure!"
        }
        #item 3160001
        if {$value < 0} {
            #item 333
            set actual -1
        } else {
            #item 3160002
            if {$value == 0} {
                #item 334
                set actual  0
            } else {
                #item 3160003
                if {$value > 0} {
                    
                } else {
                    #item 3160004
                    error "Unhandled condition."
                }
                #item 335
                set actual 1
            }
        }
        #item 336
        if {$actual == $expected} {
            
        } else {
            #item 337
            error "alt select failure!"
        }
    }

    :method fibonacci {n} {
        #item 1530001
        if {$n == 0} {
            #item 157
            set result { 0 }
        } else {
            #item 1530002
            if {$n == 1} {
                #item 158
                set result { 0 1 }
            } else {
                #item 182
                set result { 0 1 }
                #item 1630001
                set i 2
                while { 1 } {
                    #item 1630002
                    if {$i <= $n} {
                        
                    } else {
                        break
                    }
                    #item 164
                    set index2 [expr { $i - 2 }]
                    set index1 [expr { $i - 1 }]
                    set f2 [lindex $result $index2]
                    set f1 [lindex $result $index1]
                    #item 285
                    set fib \
                    [expr {$f1 + $f2}]
                    #item 165
                    lappend result $fib
                    #item 1630003
                    incr i
                }
            }
        }
        #item 168
        return $result
    }

    :method foreach_early_exit {value} {
        
        set normal_351 1
        foreach x {10 20 30} {
            #item 357
            if {$x == $value} {
                #item 361
                set found $x
                set normal_351 0
                break
            }
        }
        if {$normal_351 == 1} {
            #item 360
            set found 0
        }
        foreach x {40 20 70} {
            #item 380
            set m [ expr { $x / 2 } ]
            #item 364
            if {$m == $value} {
                #item 368
                return [expr {$x + $found}]
            }
        }
        #item 367
        return 0
    }

    :method print_list_arrow {collection} {
        #item 134
        puts "using if and arrow:"
        #item 120
        set length [llength $collection]
        set i 0
        while { 1 } {
            #item 121
            if {$i < $length} {
                
            } else {
                break
            }
            #item 119
            set item [lindex $collection $i]
            :write $item
            #item 123
            incr i
        }
        #item 135
        puts ""
    }

    :method print_list_for {collection} {
        #item 176
        puts "using for:"
        #item 130
        set length [llength $collection]
        #item 1310001
        set i 0
        while { 1 } {
            #item 1310002
            if {$i < $length} {
                
            } else {
                break
            }
            #item 133
            set item [lindex $collection $i]
            :write $item
            #item 1310003
            incr i
        }
        #item 177
        puts ""
    }

    :method print_list_foreach {collection} {
        #item 137
        puts "using foreach:"
        foreach item $collection {
            #item 112
            :write $item
        }
        #item 136
        puts ""
    }

    :method quick_sort {collection comparer} {
        #item 198
        set length [llength $collection]
        #item 1990001
        if {($length == 0) || ($length == 1)} {
            #item 210
            set result $collection
        } else {
            #item 1990003
            if {$length == 2} {
                #item 215
                set first [lindex $collection 0]
                set second [lindex $collection 1]
                #item 216
                if {[$comparer $first $second] < 0} {
                    #item 275
                    set result $collection
                } else {
                    #item 218
                    set result [list $second $first]
                }
            } else {
                #item 221
                set half [expr { $length / 2 }]
                set median [lindex $collection $half]
                set left {}
                set right {}
                #item 2220001
                set i 0
                while { 1 } {
                    #item 2220002
                    if {$i < $length} {
                        
                    } else {
                        break
                    }
                    #item 235
                    if {$i == $half} {
                        
                    } else {
                        #item 224
                        set current [lindex $collection $i]
                        #item 225
                        if {[$comparer $current $median] < 0} {
                            #item 226
                            lappend left $current
                        } else {
                            #item 227
                            lappend right $current
                        }
                    }
                    #item 2220003
                    incr i
                }
                #item 233
                set left_sorted [:quick_sort $left $comparer]
                set right_sorted [:quick_sort $right $comparer]
                #item 234
                lappend left_sorted $median
                set result [concat $left_sorted $right_sorted]
            }
        }
        #item 276
        return $result
    }

    :method string_comparer {left right} {
        #item 240
        return [string compare $left $right]
    }

    :method strings_are_sorted {array} {
        set length [llength $array]
        
        set _next_item_ 2550001
        while { 1 } {
            if {$_next_item_ == 2550001} {
                set i 0
                set _next_item_ 2550002
        
            } elseif {$_next_item_ == 2550002} {
                if {$i < $length} {
                    #item 257
                    set current [lindex $array $i]
                    set _next_item_ 2580001
                } else {
                    return {}
                }
        
            } elseif {$_next_item_ == 2580001} {
                set j [expr { $i + 1 }]
                set _next_item_ 2580002
        
            } elseif {$_next_item_ == 2580002} {
                if {$j < $length} {
                    #item 260
                    set after [lindex $array $j]
                    set _next_item_ 2650000
                } else {
                    #item 2550003
                    incr i
                    set _next_item_ 2550002
                }
        
            } elseif {$_next_item_ == 2650000} {
                set _sw2650000_ [string compare $current $after]
                set _next_item_ 2650001
        
            } elseif {$_next_item_ == 2650001} {
                if {$_sw2650000_ == -1} {
                    #item 272
                    set _next_item_ 2580003
                } else {
                    set _next_item_ 2650002
                }
        
            } elseif {$_next_item_ == 2650002} {
                if {$_sw2650000_ == 0} {
                    #item 273
                    set _next_item_ 2580003
                } else {
                    set _next_item_ 2650003
                }
        
            } elseif {$_next_item_ == 2580003} {
                incr j
                set _next_item_ 2580002
        
            } elseif {$_next_item_ == 2650003} {
                if {$_sw2650000_ == 1} {
                    set _next_item_ 274
                } else {
                    #item 2650004
                    error "Unexpected switch value: $_sw2650000_"
                    set _next_item_ 274
                }
        
            } elseif {$_next_item_ == 274} {
                set _next_item_ 261
        
            } elseif {$_next_item_ == 261} {
                error "Collection is not sorted:\n$array"
                return {}
        
            }
        }
    }

    :method test_early {value expected} {
        #item 374
        set actual \
        [:foreach_early_exit $value]
        #item 375
        if {$actual == $expected} {
            
        } else {
            #item 378
            error "foreach_early_exit failed $actual $expected"
        }
    }

    :method write {item} {
        #item 142
        puts -nonewline "$item "
    }
}
# End of class

puts "DRAKON-nx demo"
puts "=============="

set test [nx_demo new]

$test alt_select_test
$test foreach_demo
$test quick_sort_demo
