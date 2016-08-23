module Admin
  class MembersController < BaseController
    load_and_authorize_resource

    def index
      @search_field = params[:search_field]
      @search_term = params[:search_term]
      @members = Member.search(field: @search_field, term: @search_term).page params[:page]
    end

    def show
      @page = params[:page].nil? ? 1 : params[:page].to_i
      @per_page = 100
      @sort_field = params[:sort_field].nil? ? 'created_at' : params[:sort_field]
      @sort_direction =  params[:sort_direction].nil? ? 'DESC' : params[:sort_direction]

      if @sort_field == 'amount'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:amount).page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:amount).reverse_order.page(@page).per(@per_page)
        end
      elsif @sort_field == 'income'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order_by_income.page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order_by_income.reverse_order.page(@page).per(@per_page)
        end
      elsif @sort_field == 'expenses'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order_by_expenses.page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order_by_expenses.reverse_order.page(@page).per(@per_page)
        end
      elsif @sort_field == 'fee'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:fee).page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:fee).reverse_order.page(@page).per(@per_page)
        end
      elsif @sort_field == 'link'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:modifiable_type).page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:modifiable_type).reverse_order.page(@page).per(@per_page)
        end
      elsif @sort_field == 'reason'
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:reason).page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:reason).reverse_order.page(@page).per(@per_page)
        end
      else
        if @sort_direction == 'ASC'
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:created_at).page(@page).per(@per_page)
        else
          @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:created_at).reverse_order.page(@page).per(@per_page)
        end
      end


    end

    def toggle
      if params[:api]
        @member.api_disabled = !@member.api_disabled?
      else
        @member.disabled = !@member.disabled?
      end
      @member.save
    end

    def active
      @member.update_attribute(:activated, true)
      @member.save
      redirect_to admin_member_path(@member)
    end

    def gen_address
      @members = Member.search(field: @search_field, term: @search_term)
      @members.each do |member|
        member.accounts.each do |account|
          if !account.currency_obj.nil?
            if !account.payment_address.transactions.empty?
              @address = account.payment_addresses.create currency: account.currency
              @address.gen_address if @address.address.blank?
            end
          end
        end
      end
      redirect_to admin_members_path, notice: 'Deposit address for all members generated successfully!'
    end

  end
end
