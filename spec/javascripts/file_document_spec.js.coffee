describe 'FileDocument', ->
  testData = { _id: 1, file_name: 'test.jpg', file_id: 2, file_size: 256, tags: ['tag1','tag2'] }

  it 'should succeed', ->
    1.should.equal(1)

  it 'should create a new FileDocument', ->
    doc = new FileDocument(testData)
    doc.should.exist
    doc.id.should.equal(1)
    doc.file_name.should.equal('test.jpg')
    doc.file_id.should.equal(2)
    doc.file_size.should.equal(256)
    doc.location.should.equal('/files/2')
    doc.tags().should.include('tag1')
    doc.tags().should.include('tag2')

