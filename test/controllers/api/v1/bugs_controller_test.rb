require 'test_helper'
  class Api::V1::BugsControllerTest < ActionController::TestCase


        test "action create is responding" do
          get :create
          assert_response 200
        end

      test "unauthorized app can not create bugs" do
        get :create
        assert_response 200
         body_json = JSON.parse response.body
         assert_equal( body_json['status'], 'unauthorized')
      end

      test "app must provide bug[token] param to create bug" do
        get :create, params: {token: :apptoken, bug:{}, state:{os: :ios, devise: :sony, memory: 1024, storage:16000}}
        assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end

      test "app must provide bug[token] param equal to token to create bug" do
        get :create, params: {token: :apptoken,  bug:{token: :not_apptoken}, state:{os: :ios, devise: :sony, memory: 1024, storage:16000}}
         assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end

      test "app must provide state[os] param to create bug" do
        get :create, params: {token: :apptoken,  bug:{token: :apptoken}, state:{ devise: :sony, memory: 1024, storage:16000}}
         assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end

      test "app must provide state[devise] param to create bug" do
        get :create, params: {token: :apptoken,  bug:{token: :apptoken}, state:{ os: :ios, memory: 1024, storage:16000}}
         assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end

      test "app must provide state[memory] param to create bug" do
        get :create, params: {token: :apptoken,  bug:{token: :apptoken}, state:{  devise: :sony, os: :ios, storage:16000}}
         assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end


      test "app must provide state[storage] param to create bug" do
        get :create, params: {token: :apptoken,  bug:{token: :apptoken}, state:{  devise: :sony, os: :ios, memory: 1024}}
         assert_response 200
         body_json = JSON.parse response.body
         refute body_json['success']
         assert_equal body_json['message'], 'Invalid Params!'
      end

      test "app can create new bug with all params in place " do
        get :create, params: {token: :apptoken,  bug:{token: :apptoken}, state:{  devise: :sony, os: :ios, memory: 1024, storage:16000}}
         assert_response 200
         body_json = JSON.parse response.body
         assert body_json['success']
         assert_equal body_json['message'], 'will Report This Issue'
         assert body_json['bug']
      end

          test "action index is responding" do
            get :index
            assert_response 200
          end

          test "unauthorized app can't list bugs" do
            get :index
            assert_response 200
             body_json = JSON.parse response.body
             assert_equal( body_json['status'], 'unauthorized')
          end
          # 
          # test "authorized app can list his bugs only " do
          #   state1 = Api::V1::State.create!({os: :ios, devise: :sony, memory: 2048, storage:16000})
          #   state2 = Api::V1::State.create!({os: :ios, devise: :sony, memory: 1024, storage:16000})
          #   Api::V1::Bug.create({token: :apptoken,state:state1})
          #   Api::V1::Bug.create({token: :not_apptoken, state:state2})
          #   get :index, params: {token: :apptoken}
          #   assert_response 200
          #    body_json = JSON.parse response.body
          #    puts body_json
          #    assert body_json['success']
          #    assert body_json['bugs']
          #    assert_equal body_json['bugs'].length, 1
          #    assert_equal body_json['bugs'][0]['token'], :apptoken
          # end




  end
