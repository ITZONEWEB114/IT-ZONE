# encoding: utf-8

Product.delete_all
Product.create(:title => 'Web Design for Developers',
  :description => 
    %{<p>
        <em>Web Design for Developers</em> will show you how to make your
        web-based application look professionally designed. We'll help you
        learn how to pick the right colors and fonts, avoid costly interface
        and accessibility mistakes -- your application will really come alive.
        We'll also walk you through some common Photoshop and CSS techniques
        and work through a web site redesign, taking a new design from concept
        all the way to implementation.
      </p>},
  :image_url =>   '/images/wd4d.jpg',    
  :price => 42.95)

# . . .
Product.create(:title => 'Programming Ruby 1.9',
  :description =>
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  :image_url => '/images/ruby.jpg',
  :price => 49.50)

# . . .

Product.create(:title => 'Rails Test Prescriptions',
  :description => 
    %{<p>
        <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
        Rails applications, covering Test-Driven Development from both a
        theoretical perspective (why to test) and from a practical perspective
        (how to test effectively). It covers the core Rails testing tools and
        procedures for Rails 2 and Rails 3, and introduces popular add-ons,
        including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
      </p>},
  :image_url => '/images/rtp.jpg',
  :price => 43.75)
# . . .

# Product.create(:title => '',
  # :description => 
    # %{<p>
        
      # </p>},
  # :image_url => '/images/.jpg',
  # :price => ,
  # :category_ids => [Category.where(:name => '').first.id])
#. . .

Product.create(:title => 'Debug it',
  :description => 
    %{<p>
        This book distills decades of hard-won experience gained in 
        the trenches of professional software development, giving you a head-start and 
        arming you with the tools you need to get to the bottom of the problem, whatever 
        you're faced with. Whether you're writing Java or assembly language, targeting 
        servers or embedded micro-controllers, using agile or traditional approaches, 
        the same basic bug-fixing principles apply. From constructing software that is 
        easy to debug (and incidentally less likely to contain bugs in the first place), 
        through handling bug reports to rolling out your ultimate fix, we'll cover the 
        entire life-cycle of a bug. You'll learn about the empirical approach, which 
        leverages your software's unique ability to show you what's really happening, 
        the importance of finding a reliable and convenient means of reproducing a bug, 
        and common pitfalls so you can avoid them. You'll see how to use commonly available 
        tools to automatically detect problems before they're reported by customers and 
        how to construct "transparent software" that provides access to critical information 
        and internal state. 
      </p>},
  :image_url => '/images/debug.jpg',
  :price => 45.76)

User.delete_all
User.create(:name => 'admin',
  :password => 'admin',:password_confirmation=>'admin')
	
Customer.delete_all
Customer.create( :name => 'customer',
	:password => 'customer', :password_confirmation => 'customer', :email => 'a@b.c', :is_activated => true)

LineItem.delete_all
Cart.delete_all
Comment.delete_all
Order.delete_all