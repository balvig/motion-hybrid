module MotionHybrid
  describe Navigatable do
    describe '.path_for' do
      it "should parse path correctly for localhost" do
        MotionHybrid::Screen.path_for('http://localhost:3000/chats').should == '/chats'
      end
    end

    describe '.route' do
      class MyScreen < Screen
        attr_accessor :external
        route /.*/ do |request, external|
          self.external = external
        end
      end

      it "determines whether request is external or not" do
        MyScreen.root_url = 'http://mysite.com'
        screen = MyScreen.new
        internal_request = NSURLRequest.requestWithURL NSURL.URLWithString('http://mysite.com/users/')
        external_request = NSURLRequest.requestWithURL NSURL.URLWithString('http://theirsite.com/users/')

        screen.on_request(internal_request, UIWebViewNavigationTypeLinkClicked)
        screen.external.should == false
        screen.on_request(external_request, UIWebViewNavigationTypeLinkClicked)
        screen.external.should == true
      end
    end
  end
end
