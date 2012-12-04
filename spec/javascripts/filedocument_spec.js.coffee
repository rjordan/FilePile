describe 'FileDocument', ->
  it 'should exist', ->
    expect(FileDocument).toBeDefined

  model = new FileDocument {}

  it 'should accept new tags', ->
    model.tags = ['tag1', 'tag2']
    expect(model.tags).toNotContain('tag3')
    model.addTag('tag3')
    expect(model.tags).toContain('tag3')

  it 'should ignore duplicate tags', ->
    model.tags = ['tag1', 'tag2']
    expect(model.tags.length).toEqual(2)
    model.addTag('tag2')
    expect(model.tags.length).toEqual(2)

  it 'should be able to remove existing tags', ->
    model.tags = ['tag1', 'tag2']
    expect(model.tags).toContain('tag2')
    model.removeTag('tag2')
    expect(model.tags).toNotContain('tag2')

  it 'should handle small sizes', ->
    model.file_size = 42
    expect(model.formattedFileSize()).toEqual('42 B')

  it 'should handle larger sizes', ->
    model.file_size = 42200
    expect(model.formattedFileSize()).toEqual('42.20 KB')
