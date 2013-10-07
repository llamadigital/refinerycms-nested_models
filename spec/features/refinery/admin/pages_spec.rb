# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Admin" do
    describe "pages", :js => true do
      refinery_login_with :refinery_user

      describe "create" do
        before do
          visit refinery.admin_pages_path
          click_link "Add new page"
          fill_in 'Title', with: 'Page Title'
        end

        context "adding no nested models" do
          it "should create no nested models" do
            expect {
              click_button "Save"
            }.to_not change{ NestedModel.count }.from(0)
            page = Refinery::Page.first
            expect(page.nested_models.count).to eql(0)
          end
        end

        context "adding 1 nested model" do
          it "should create 1 nested model" do
            expect {
              click_link 'Add nested model'
              click_button "Save"
            }.to change{ NestedModel.count }.from(0).to(1)
            page = Refinery::Page.first
            expect(page.nested_models.count).to eql(1)
            nested_model = NestedModel.first
            expect(page.nested_models.first).to eql(nested_model)
          end
        end
        
        let(:random){ rand(28)+2 }

        context "adding random number of nested models" do
          it "should create random nested models" do
            expect {
              random.times do
                click_link 'Add nested model'
              end
              click_button "Save"
            }.to change{ NestedModel.count }.from(0).to(random)
            page = Refinery::Page.first
            expect(page.nested_models.count).to eql(random)
            expect(page.nested_models.sort_by(&:id)).to eql(NestedModel.all.sort_by(&:id))
          end
        end

        context "adding and removing a nested model" do
          it "should create no nested models" do 
            expect {
              click_link 'Add nested model'
              click_link 'Remove this nested model'
              click_button "Save"
            }.to_not change{ NestedModel.count }.from(0)
            expect(Refinery::Page.count).to eql(1)
          end
        end

        context "adding and removing multiple nested models" do
          it "should create no nested models" do
            expect {
              click_link 'Add nested model'
              click_link 'Add nested model'
              first('fieldset').find('[data-remove="true"]').click
              first('fieldset').find('[data-remove="true"]').click
              click_button "Save"
            }.to_not change{ NestedModel.count }.from(0)
          end
        end

        context "adding multiple nested models and removing one" do
          it "should create multiple nested models" do 
            expect {
              click_link 'Add nested model'
              click_link 'Add nested model'
              first('fieldset').find('[data-remove="true"]').click
              click_button "Save"
            }.to change{ NestedModel.count }.from(0).to(1)
            page = Refinery::Page.first
            nested_model = NestedModel.first
            expect(page.nested_models.first).to eql(nested_model)
          end
        end

      end

    end
  end
end

