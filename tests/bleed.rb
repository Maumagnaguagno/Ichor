require 'test/unit'
require './ichor'

class Bleed < Test::Unit::TestCase

  def test_input_type
    assert_raises(TypeError) {Ichor.scan_tokens(nil)}
  end

  def test_malformed_expression_exception
    e = assert_raises(RuntimeError) {Ichor.scan_tokens('')
    assert_equal('Malformed expression', e.message)}
    e = assert_raises(RuntimeError) {Ichor.scan_tokens(" \t\v\n\r")}
    assert_equal('Malformed expression', e.message)
    e = assert_raises(RuntimeError) {Ichor.scan_tokens('a b')}
    assert_equal('Malformed expression', e.message)
    e = assert_raises(RuntimeError) {Ichor.scan_tokens('() ()')}
    assert_equal('Malformed expression', e.message)
  end

  def test_missing_parentheses_exception
    e = assert_raises(RuntimeError) {Ichor.scan_tokens('(()')}
    assert_equal('Missing close parentheses', e.message)
    e= assert_raises(RuntimeError) {Ichor.scan_tokens('())')}
    assert_equal('Missing open parentheses', e.message)
  end

  def test_symbol
    ['a', 'aether', ':a-b+c^0?'].each {|s| assert_equal(s, Ichor.scan_tokens(s))}
  end

  def test_lists
    assert_equal([], Ichor.scan_tokens('()'))
    assert_equal([[]], Ichor.scan_tokens('(())'))
    assert_equal(['a', ['b'], [['c']]], Ichor.scan_tokens('(a (b) (( c  ) ))'))
  end

  def test_whitespaces
    assert_equal([], Ichor.scan_tokens('  ()  '))
    assert_equal([], Ichor.scan_tokens(' (    ) '))
    assert_equal(['a', 'b'], Ichor.scan_tokens("\n(\ta\nb ) \n "))
  end
end