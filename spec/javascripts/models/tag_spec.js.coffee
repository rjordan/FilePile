#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/tag

describe 'Tag', ->
  it 'should exist', ->
    expect(Tag).toBeDefined

  model = new Tag('tag1')
  it 'should have an id', ->
    expect(model.id).toBeDefined
  it 'should have be selectable', ->
    expect(model.selected).toBeDefined

  describe 'when new', ->
    model = new Tag('tag1')
    it 'should set id', ->
      expect(model.id).toEqual('tag1')
    it 'should set selected to false', ->
      expect(model.selected).toBeFalsy



