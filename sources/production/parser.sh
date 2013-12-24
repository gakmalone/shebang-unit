function parser::get_public_functions_in_file() {
	local file=$1
	local functions=()
	parser::_find_functions_in_file "${file}" | parser::_filter_private_functions | {
		local name; while read name; do
			printf "${name} "
		done
	}
}

function parser::_find_functions_in_file() {
	local file=$1
	grep -o "^function.*()" "${file}" | parser::_get_function_name_from_declaration | tr -d " "
}

function parser::_filter_private_functions() {
	grep -v "^_.*"
}

function parser::_get_function_name_from_declaration() {
	sed "s/function\(.*\)()/\1/"
}