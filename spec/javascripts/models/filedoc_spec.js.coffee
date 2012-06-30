#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/filedoc

describe 'FileDoc', ->
  it 'should exist', ->
    expect(FileDoc).toBeDefined

  describe 'when new', ->
    model = new FileDoc()

  model = new FileDoc()
  it 'should accept new tags', ->
    model.tags = ['tag1', 'tag2']
    expect(model.tags).toNotContain('tag3')
    model.addTag('tag3')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags).toContain('tag3')

  it 'should ignore duplicate tags', ->
    model.tags = ['tag1','tag2']
    expect(model.tags.length).toEqual(2)
    model.addTag('tag2')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags.length).toEqual(2)

  it 'should be able to remove existing tags', ->
    model.tags = ['tag1','tag2']
    expect(model.tags).toContain('tag2')
    model.removeTag('tag2')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags).toNotContain('tag2')


