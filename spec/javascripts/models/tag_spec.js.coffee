#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/tag

describe 'Tag', ->
  it 'should exist', ->
    expect(Tag).toBeDefined

  model = new Tag()
  it 'should have a value', ->
    expect(model.value).toBeDefined
  it 'should have be selectable', ->
    expect(model.selected).toBeDefined

  describe 'when new', ->
    it 'should set value to empty', ->
      expect(model.value).toEqual('')
    it 'should set selected to false', ->
      expect(model.selected).toBeFalsy



