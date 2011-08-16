class WeeklyInvoiceReport < Report

  def get_workbook(source, params)
    workbook = Spreadsheet.open "#{Rails.root}/doc/templates/weekly-invoice-report.xls"
    source_columns = workbook.worksheets.first.row(7).as_json
    sheet = workbook.worksheets.first
    
    hash_array = get_hash_array(source, params)
    hash_array.each_with_index do |hash_row, row|
      hash_row.each_with_index do |(key, value), col|
        #sheet.row(0).push key.dup.to_s if index == 0
        sheet[(row+11),col] = value
      end
    end
    
    offset = params[:report][:weeks_ago].to_i * -1

    if source
      #Client Details
      sheet[5,1] = source.name
      sheet[6,1] = source.address
      sheet[7,1] = "#{source.city}, #{source.region} #{source.code}"
    end
    
    #Date
    sheet[9,0] = "SUMMARY OF NPO FOR THE WEEK ENDING : "+find_day_by_name(:previous,"Fri",offset).to_s(:date)
    
    cur_time = Time.now.to_i.to_s
    
    workbook.write 'tmp/reports/'+cur_time+'-weekly-invoice-report.xls'
    
    'tmp/reports/'+cur_time+'-weekly-invoice-report.xls'
  end
  
  def get_hash_array(source, params)
    output = []
    offset = params[:report][:weeks_ago].to_i * -1
    
    job_list = (source)? JobCategory.where(:name => "Digital").first.assignments.where(:client_id => source.id).where("endtime < '#{find_day_by_name(:next,"Fri",offset)}' AND endtime > '#{find_day_by_name(:previous,"Fri",offset)}'") : JobCategory.where(:name => "Digital").first.assignments.all
    
    #TODO take the hash out, since you're putting shit in order
    job_list.each do |job|
      tmp_hash = Hash.new()
      tmp_hash["Job"] = job.id
      tmp_hash["Date"] = job.endtime.to_s(:date) if job.endtime
      requestor = job.users.joins(:role).where(:user => { :roles => { :category => "client" } }).first
      tmp_hash["Pearson Requestor"] = (requestor!=nil)? requestor.full_name : requestor;
      tmp_hash["ISBN"] = job.print_order.outline.isbn_code
      tmp_hash["Title Description"] = job.print_order.outline.name
      tmp_hash["PON"] = job.clientpo
      tmp_hash["Print"] = job.print_order.internal_count
      tmp_hash["Quantity Ordered"] = job.print_order.quantity
      tmp_hash["Quantity Shipped"] = job.print_order.shipped
      tmp_hash["Page Count"] = job.print_order.outline.pages
      tmp_hash["Impressions"] = job.print_order.outline.pages * job.print_order.shipped
      tmp_hash["Unit Price"] = "%0.2f" % job.quote_total
      tmp_hash["Additional Work"] = job.print_order.outline.notes
      tmp_hash["Cost Centre"] = job.print_order.cc
      tmp_hash["BA"] = job.print_order.ba
      tmp_hash["GL Account"] = job.print_order.gl
      tmp_hash["Extended Price"] = job.quote_total * job.print_order.shipped
      
      output << tmp_hash
    end
    
    output
  end
  
  private 
  
    include Util
end
