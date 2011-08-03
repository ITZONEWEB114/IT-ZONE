require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["wuyi@51.com"], mail.to
    assert_equal ["itzoneweb114@126.com"], mail.from
    assert_match /1 x The Ruby Programming Language 1.9/, mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["wuyi@51.com"], mail.to
    assert_equal ["itzoneweb114@126.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td><a.*The Ruby Programming Language 1.9<\/a><\/td>/, mail.body.encoded
  end

end
