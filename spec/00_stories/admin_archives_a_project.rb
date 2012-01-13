require 'spec_helper'

steps "Admin archives a project", :type => :request do
  let! :client_1 do Factory(:client, :name => 'Foo, Inc.', :abbreviation => 'FOO') end
  let! :client_2 do Factory(:client, :name => 'Bar, Inc.', :abbreviation => 'BAR') end
  let! :project_2 do Factory(:project, :client => client_1, :name => "Project 2 base") end
  let! :project_2a do Factory(:project, :parent => project_2, :name => "Project 2a") end
  let! :project_2b do Factory(:project, :parent => project_2, :name => "Project 2b") end

  let! :project_3 do Factory(:project, :client => client_2, :name => 'Project 3 base') end
  let! :project_3a do Factory(:project, :parent => project_3, :name => 'Project 3a') end
  let! :admin do Factory(:admin) end

  it "should login as the admin" do
    visit root_path
    fill_in "Login", :with => admin.login
    fill_in "Password", :with => admin.password
    click_button 'Login'
  end

  it "should show all the projects in the picker" do
    within '#project_picker' do
      page.should have_content('Project 2 base')
      page.should have_content('Project 2a')
      page.should have_content('Project 2b')
      page.should have_content('Project 3 base')
      page.should have_content('Project 3a')
    end
  end



end
