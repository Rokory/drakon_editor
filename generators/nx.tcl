
gen::add_generator NX gen_nx::generate

namespace eval gen_nx {

variable keywords

array set keywords [array get gen_tcl::keywords]

proc highlight { tokens } {
	return [gen_tcl::highlight tokens]
}

proc make_callbacks { } {
	set callbacks {}
	
	gen::put_callback callbacks assign			gen_tcl::p.assign
	gen::put_callback callbacks compare			gen_tcl::p.compare
	gen::put_callback callbacks compare2		gen_tcl::p.compare2
	gen::put_callback callbacks while_start 	gen_tcl::p.while_start
	gen::put_callback callbacks if_start		gen_tcl::p.if_start
	gen::put_callback callbacks elseif_start	gen_tcl::p.elseif_start
	gen::put_callback callbacks if_end			gen_tcl::p.if_end
	gen::put_callback callbacks else_start		gen_tcl::p.else_start
	gen::put_callback callbacks pass			gen_tcl::p.pass
	gen::put_callback callbacks continue		gen_tcl::p.continue
	gen::put_callback callbacks return_none		gen_tcl::p.return_none
	gen::put_callback callbacks block_close		gen_tcl::p.block_close
	gen::put_callback callbacks comment			gen_tcl::p.comment
	gen::put_callback callbacks bad_case		gen_tcl::p.bad_case
	gen::put_callback callbacks for_init		gen_tcl::foreach_init
	gen::put_callback callbacks for_check		gen_tcl::foreach_check
	gen::put_callback callbacks for_current		gen_tcl::foreach_current
	gen::put_callback callbacks for_incr		gen_tcl::foreach_incr
	gen::put_callback callbacks body			gen_tcl::generate_body
	gen::put_callback callbacks signature		gen_tcl::extract_signature
	gen::put_callback callbacks and				gen_tcl::p.and
	gen::put_callback callbacks or				gen_tcl::p.or
	gen::put_callback callbacks not				gen_tcl::p.not
	gen::put_callback callbacks break			"break"
	gen::put_callback callbacks declare			gen_tcl::p.declare
	gen::put_callback callbacks for_declare		gen_tcl::for_declare
	gen::put_callback callbacks shelf			gen_tcl::shelf
	gen::put_callback callbacks if_cond			gen_tcl::if_cond
	gen::put_callback callbacks native_foreach		gen_tcl::native_foreach


	return $callbacks
}

proc generate { db gdb filename } {
	global errorInfo
	set callbacks [ make_callbacks ]

	gen::fix_graph $gdb $callbacks 0
	unpack [ gen::scan_file_description $db { header footer } ] header footer

	set use_nogoto 1
	set functions [ gen::generate_functions $db $gdb $callbacks $use_nogoto ]

	tab::generate_tables $gdb $callbacks 0

	if { [ graph::errors_occured ] } { return }



	set hfile [ replace_extension $filename "tcl" ]
	set f [ open_output_file $hfile ]
	catch {
	
	
#		tab::core_debug_print stdout gen_tcl::field_selector	
	
		p.print_to_file $f $functions $header $footer
	} error_message
	set savedInfo $errorInfo
	
	catch { close $f }
	if { $error_message != "" } {
		puts $errorInfo
		error $error_message savedInfo
	}
}

proc build_declaration { name signature } {
	unpack $signature type access parameters returns
	set result "proc $name \{"
	foreach parameter $parameters {
		append result " " [ lindex $parameter 0 ]
	}
	return "$result \} \{"
}

proc p.print_to_file { fhandle functions header footer } {
	if { $header != "" } {
		puts $fhandle $header
	}
	set version [ version_string ]
	puts $fhandle \
	    "# Autogenerated with DRAKON Editor $version"

	init_current_file $fhandle
	gen_tcl::generate_data_struct


	foreach function $functions {
		unpack $function diagram_id name signature body
		set type [ lindex $signature 0 ]
		if { $type != "comment" } {
			puts $fhandle ""
			set declaration [ build_declaration $name $signature ]
			puts $fhandle $declaration
			set lines [ gen::indent $body 1 ]
			puts $fhandle $lines
			puts $fhandle "\}"
		}
	}
	puts $fhandle ""
	puts $fhandle $footer
}

}

