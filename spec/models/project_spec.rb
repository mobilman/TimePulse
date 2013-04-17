# == Schema Information
#
# Table name: projects
#
#  id          :integer(4)      not null, primary key
#  parent_id   :integer(4)
#  lft         :integer(4)
#  rgt         :integer(4)
#  client_id   :integer(4)
#  name        :string(255)     not null
#  account     :string(255)
#  description :text
#  clockable   :boolean(1)      default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#  billable    :boolean(1)      default(TRUE)
#  flat_rate   :boolean(1)      default(FALSE)
#


require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do

  let :root_project do Project.root end

  it "should create a new instance given valid attributes" do
    Factory(:project)
  end

  it "should require a name" do
    Factory.build(:project, :name => nil).should_not be_valid
  end

  describe "cascades" do
    describe "client" do
      before(:each) do
        @client = Factory(:client)
        @client2 = Factory(:client)
      end
      it "should return a project's client" do
        Factory(:project, :client => @client).client.should == @client
      end
      it "should return a project's parent's client if the project has no client" do
        @parent = Factory(:project, :client => @client)
        Factory(:project, :client_id => nil, :parent => @parent).client.should == @client
      end
      it "should return a project's grandparent's client if the project and parent have no client" do
        @grandparent = Factory(:project, :client => @client, :name => 'GP')
        @parent = Factory(:project, :parent => @grandparent, :client_id => nil, :name => "P")
        @project = Factory(:project, :client_id => nil, :parent => @parent)
        @project.ancestors.reverse.should == [ @parent, @grandparent, root_project ]
        @project.client.should == @client
      end
      it "should return a project's parent's client if the project has no client and the grandparent has a different client" do
        @grandparent = Factory(:project, :client => @client)
        @parent = Factory(:project, :parent => @grandparent, :client => @client2)
        @project = Factory(:project, :client_id => nil, :parent => @parent)
        @project.ancestors.reverse.should == [ @parent, @grandparent, root_project ]
        @project.client.should == @client2
      end
    end
    describe "account" do
      it "should return a project's client" do
        Factory(:project, :account => "account").account.should == "account"
      end
      it "should return a project's parent's client if the project has no client" do
        @parent = Factory(:project, :account => "account")
        Factory(:project, :account => nil, :parent => @parent).account.should == "account"
      end
      it "should return a project's grandparent's client if the project and parent have no client" do
        @grandparent = Factory(:project, :account => "account", :name => 'GP')
        @parent = Factory(:project, :parent => @grandparent, :account => nil, :name => "P")
        @project = Factory(:project, :account => nil, :parent => @parent)
        @project.ancestors.reverse.should == [ @parent, @grandparent, root_project ]
        @project.account.should == "account"
      end
      it "should return a project's parent's client if the project has no client and the grandparent has a different client" do
        @grandparent = Factory(:project, :account => "account")
        @parent = Factory(:project, :parent => @grandparent, :account => "account2")
        @project = Factory(:project, :account => nil, :parent => @parent)
        @project.ancestors.reverse.should == [ @parent, @grandparent, root_project ]
        @project.account.should == "account2"

        @grandparent.reload.descendants.should include(@parent)
        @grandparent.reload.descendants.should include(@project)
      end
    end
  end


end
