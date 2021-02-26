class GenerateReports 
  include Interactor
  MONEY_FIELDS = %i[daily_charges taxes_compansation account_service_compensation rent_compansation].freeze

  def call
    users = User.all
    users.each do |user|
      date_additionals = (user.additionals || []).select {  |additional| additional[:date].eql? Date.today }
      user.update(additionals: (user.additionals || []) - date_additionals) 
   
      report = user.reports.create(daily_charges: user.salary / 20, additionals: date_additionals )
      report.update(invoice_total: invoice_total(report))
    end
  end
 
  private

  def invoice_total(report)
    [report.slice(*MONEY_FIELDS).sum, report.additionals.sum { |additional| additional[:amount] }].sum.round(2)
  end
end
