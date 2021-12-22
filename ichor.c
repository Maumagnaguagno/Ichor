#include "ruby.h"

static VALUE rb_scan_tokens(VALUE self, VALUE filename)
{
  Check_Type(filename, T_STRING);
  char *pos = RSTRING_PTR(filename);
  VALUE stack = rb_ary_new();
  VALUE list = rb_ary_new();
  while(*pos)
  {
    if(*pos == '(')
    {
      rb_ary_push(stack, list);
      list = rb_ary_new();
      ++pos;
    }
    else if(*pos == ')')
    {
      if(RARRAY_LEN(stack) == 0) rb_raise(rb_eRuntimeError, "Missing open parentheses");
      else list = rb_ary_push(rb_ary_pop(stack), list);
      ++pos;
    }
    else
    {
      while(isspace(*pos)) ++pos;
      char *begin = pos;
      while(*pos && !isspace(*pos) && *pos != '(' && *pos != ')') ++pos;
      if(begin != pos) rb_ary_push(list, rb_str_new(begin, pos - begin));
    }
  }
  if(RARRAY_LEN(stack) != 0) rb_raise(rb_eRuntimeError, "Missing close parentheses");
  if(RARRAY_LEN(list) != 1) rb_raise(rb_eRuntimeError, "Malformed expression");
  return RARRAY_AREF(list, 0);
}

void Init_ichor(void)
{
  VALUE Scanner_id = rb_define_module("Ichor");
  rb_define_singleton_method(Scanner_id, "scan_tokens", rb_scan_tokens, 1);
}