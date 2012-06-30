#=require_tree ./

testData = { id: 1, file_name: "test.jpg", file_id: 2, file_size: 256, tags: ["tag1","tag2"] }

$.mockjax
  url: '/files'
  responseTime: 100
  responseText: [testData]

$.mockjax
  url: '/files/1'
  responseTime: 100
  responseText: testData
