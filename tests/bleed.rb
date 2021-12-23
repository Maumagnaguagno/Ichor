require 'test/unit'
require './ichor'

class Bleed < Test::Unit::TestCase

  def test_malformed_expression_exception
    e = assert_raises(RuntimeError) {''.to_sexpr}
    assert_equal('Malformed expression', e.message)
    e = assert_raises(RuntimeError) {" \t\v\n\r".to_sexpr}
    assert_equal('Malformed expression', e.message)
    e = assert_raises(RuntimeError) {'a b'.to_sexpr}
    assert_equal('Malformed expression', e.message)
    e = assert_raises(RuntimeError) {'() ()'.to_sexpr}
    assert_equal('Malformed expression', e.message)
  end

  def test_missing_parentheses_exception
    e = assert_raises(RuntimeError) {'(()'.to_sexpr}
    assert_equal('Missing close parentheses', e.message)
    e= assert_raises(RuntimeError) {'())'.to_sexpr}
    assert_equal('Missing open parentheses', e.message)
  end

  def test_symbol
    ['a', 'aether', ':a-b+c^0?'].each {|s| assert_equal(s, s.to_sexpr)}
  end

  def test_lists
    assert_equal([], '()'.to_sexpr)
    assert_equal([[]], '(())'.to_sexpr)
    assert_equal(['a', ['b'], [['c']]], '(a (b) (( c  ) ))'.to_sexpr)
  end

  def test_whitespaces
    assert_equal([], '  ()  '.to_sexpr)
    assert_equal([], ' (    ) '.to_sexpr)
    assert_equal(['a', 'b'], "\n(\ta\nb ) \n ".to_sexpr)
  end
end