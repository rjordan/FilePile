#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/tag
#= require mustache
#= require controllers/tags

describe 'Tags', ->
  it 'should exist', ->
    expect(Tags).toBeDefined()
  it 'should have property all', ->
    expect(Tags.all).toBeDefined()

  it 'should accept new tags', ->
    expect(Tags.all.length).toBe(0)
    Tags.add('tag1')
    expect(Tags.all.length).toBe(1)

  it 'should be able to clear tags', ->
    Tags.add('tag1')
    expect(Tags.all.length).toBeGreaterThan(0)
    Tags.clear()
    expect(Tags.all.length).toBe(0)

  it 'should NOT accept duplicate tags', ->
    expect(Tags.all.length).toBe(0)
    Tags.add('tag1')
    Tags.add('tag1')
    expect(Tags.all.length).toBe(1)
