require "spec_helper"

describe KanbansController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/kanbans").to route_to("kanbans#index")
    end

    it "routes to #new" do
      expect(:get => "/kanbans/new").to route_to("kanbans#new")
    end

    it "routes to #show" do
      expect(:get => "/kanbans/1").to route_to("kanbans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/kanbans/1/edit").to route_to("kanbans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/kanbans").to route_to("kanbans#create")
    end

    it "routes to #update" do
      expect(:put => "/kanbans/1").to route_to("kanbans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/kanbans/1").to route_to("kanbans#destroy", :id => "1")
    end

  end
end
