describe 'MotionRails::BasicRoutes' do

  extend WebStub::SpecHelpers
  tests MotionRails::Screen

  before do
    disable_network_access!
  end

  after do
    @screen = nil
    enable_network_access!
  end

  def controller
    MotionRails::Screen.root_url = 'http://github.com'
    @screen ||= MotionRails::Screen.new(path: '/', nav_bar: true)
    @screen.navigationController
  end

  it "basic GET link" do
    stub_request(:get, "http://github.com/").to_return(body: '<a href="/page_2" id="link">To page 2</a>')
    stub_request(:get, "http://github.com/page_2").to_return(body: 'This is page 2')

    wait 0.6 do
      @screen.html.include?('To page 2').should == true
      @screen.evaluate('document.getElementById("link").click();')
      wait 0.6 do
        @screen.presentedViewController.nil?.should == true
        @screen.navigationController.viewControllers.count.should == 2
        @screen.navigationController.topViewController.html.include?('This is page 2').should == true
      end
    end
  end

  it "inline #self link" do
    stub_request(:get, "http://github.com/").to_return(body: '<a href="/page_2#self" id="link">To page 2</a>')
    stub_request(:get, "http://github.com/page_2").to_return(body: 'This is page 2')

    wait 0.6 do
      @screen.evaluate('document.getElementById("link").click();')
      wait 0.6 do
        @screen.html.include?('This is page 2').should == true
        @screen.navigationController.viewControllers.count.should == 1
      end
    end
  end

  it "modal #modal link" do
    stub_request(:get, "http://github.com/").to_return(body: '<a href="/page_2#modal" id="link">To page 2</a>')
    stub_request(:get, "http://github.com/page_2").to_return(body: 'This is page 2')

    wait 0.6 do
      @screen.evaluate('document.getElementById("link").click();')
      wait 0.6 do
        @screen.navigationController.viewControllers.count.should == 1
        @screen.presentedViewController.viewControllers.first.html.include?('This is page 2').should == true
      end
    end
  end

  it "going to url of presenter from modal closes the modal" do
    stub_request(:get, "http://github.com/").to_return(body: '<a href="/modal#modal" id="link">To modal</a>')
    stub_request(:get, "http://github.com/modal").to_return(body: '<a href="/" id="link">Close</a>')

    wait 0.6 do
      @screen.evaluate('document.getElementById("link").click();')
      wait 0.6 do
        @screen.navigationController.viewControllers.count.should == 1
        @modal = @screen.presentedViewController.viewControllers.first
        @modal.html.include?('Close').should == true
        @modal.evaluate('document.getElementById("link").click();')
        wait 0.6 do
          @screen.presentedViewController.nil?.should == true
        end
      end
    end
  end

  #it "#hide_tab_bar link" do
    #stub_request(:get, "http://github.com/").to_return(body: '<a href="/page_2#hide_tab_bar" id="link">To page 2</a>')
    #stub_request(:get, "http://github.com/page_2#hide_tab_bar").to_return(body: 'This is page 2')

    #wait 0.6 do
      #@screen.evaluate('document.getElementById("link").click();')
      #wait 0.6 do
        #@screen.navigationController.viewControllers.count.should == 2
        #@screen.navigationController.viewControllers.last.html.include?('This is page 2').should == true
      #end
    #end
  #end
  #

end
