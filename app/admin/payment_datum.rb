ActiveAdmin.register PaymentDatum do

  action_item :import do
    link_to 'Import', import_admin_payment_data_path
  end

  

  collection_action :import, method: :get do

  end

  collection_action :import_data, method: :post do
    if xlsx_data = Roo::Spreadsheet.open(params[:file].path)
      headers = xlsx_data.row(1)
      xlsx_data.each_with_index do |row, idx|
        next if idx == 0 # skip header
        # create hash from headers and cells
        payment_data = Hash[[headers, row].transpose]
        pd = PaymentDatum.new(payment_data)
        unless pd.save
          raise ActiveRecord::Rollback
        end  
      end
      flash[:notice] = "Payment Data has successfully imported"
      redirect_to :action => :index
    else
      flash[:notice] = "Something went wrong"
      redirect_to  import_admin_payment_data_path
    end  
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :application_identifier, :application_type, :approval_for, :status, :payment_id, :app_id, :amount, :transaction_id, :revised_fee, :payment_status, :paynimo_status, :payment_completed_at, :payment_method, :order_id, :razorpay_payment_id, :razorpay_order_id, :remarks, :razorpay_signature, :razorpay_status, :district_administration_area, :district, :ulb_name, :circle
  #
  # or
  #
  # permit_params do
  #   permitted = [:application_identifier, :application_type, :approval_for, :status, :payment_id, :app_id, :amount, :transaction_id, :revised_fee, :payment_status, :paynimo_status, :payment_completed_at, :payment_method, :order_id, :razorpay_payment_id, :razorpay_order_id, :remarks, :razorpay_signature, :razorpay_status, :district_administration_area, :district, :ulb_name, :circle]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
