from robot.api.deco import keyword
import time


@keyword('Select data from database') #with this decorator we changes func name to written in @keyword(...)
def query(request):
    print('*ERROR:%d* message with timestamp' % (time.time()*1000)) # in robot logger will display ERROR message that was wrote in this print

def _hiden_function(arg): # this function invisible in robot.
    pass

def execute_sql_string(string):
    print(string)

@keyword('Add ${quantity:\d+} Copies Of ${item} To Cart') # we can add params in keyword instead ${...}, when call keyword
def add_copies_to_cart(quantity, item):
    print(quantity, item)
