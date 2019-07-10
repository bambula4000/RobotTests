import hashlib
from robot.api.deco import keyword

__all__ = ["compare_hash_sum", "calculate_md5", "convert_str_to_list", "find_in_list"]

@keyword('compare_hash_sum_of_two_args')
def compare_hash_sum(arg1, arg2):
    print('DEBUG: message from "def compare_hash_sum"')
    if arg1 == arg2:
        return True
    return False

@keyword('calculate ${file_name} MD5')
def calculate_md5(string):
    print('DEBUG: message from "def calculate_md5"')
    return hashlib.md5(string).hexdigest()

@keyword('Add_string_to_list')
def convert_str_to_list(string):
    print('DEBUG: message from "def convert_str_to_list"')
    list_var = [string]
    return list_var

@keyword('find_value_in_list')
def find_in_list(list_var, template):
    print('DEBUG: message from "def find_in_list"')
    convert_to_string = ', '.join(list_var)
    result = convert_to_string.find(template)
    return result

def will_not_import():
    pass
