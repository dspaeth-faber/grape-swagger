require 'spec_helper'

describe 'Form Params' do
  def app
    Class.new(Grape::API) do
      format :json

      params do
        requires :name, type: String, desc: 'name of item'
      end
      post '/items' do
        {}
      end

      params do
        requires :id, type: Integer, desc: 'id of item'
        requires :name, type: String, desc: 'name of item'
      end
      put '/items/:id' do
        {}
      end

      params do
        requires :id, type: Integer, desc: 'id of item'
        requires :name, type: String, desc: 'name of item'
      end
      patch '/items/:id' do
        {}
      end

      add_swagger_documentation
    end
  end

  subject do
    get '/swagger_doc/items.json'
    JSON.parse(last_response.body)
  end

  it 'retrieves the documentation form params' do
    expect(subject['apis']).to eq([
      {
        'path' => '/items.{format}',
        'operations' => [
          {
            'notes' => '',
            'summary' => '',
            'nickname' => 'POST-items---format-',
            'method' => 'POST',
            'parameters' => [{ 'paramType' => 'form', 'name' => 'name', 'description' => 'name of item', 'type' => 'string', 'required' => true, 'allowMultiple' => false }],
            'type' => 'void'
          }
        ]
      }, {
        'path' => '/items/{id}.{format}',
        'operations' => [
          {
            'notes' => '',
            'summary' => '',
            'nickname' => 'PUT-items--id---format-',
            'method' => 'PUT',
            'parameters' => [{ 'paramType' => 'path', 'name' => 'id', 'description' => 'id of item', 'type' => 'integer', 'required' => true, 'allowMultiple' => false, 'format' => 'int32' }, { 'paramType' => 'form', 'name' => 'name', 'description' => 'name of item', 'type' => 'string', 'required' => true, 'allowMultiple' => false }],
            'type' => 'void'
          },
          {
            'notes' => '',
            'summary' => '',
            'nickname' => 'PATCH-items--id---format-',
            'method' => 'PATCH',
            'parameters' => [{ 'paramType' => 'path', 'name' => 'id', 'description' => 'id of item', 'type' => 'integer', 'required' => true, 'allowMultiple' => false, 'format' => 'int32' }, { 'paramType' => 'form', 'name' => 'name', 'description' => 'name of item', 'type' => 'string', 'required' => true, 'allowMultiple' => false }],
            'type' => 'void'
          }
        ]
      }])
  end
end
