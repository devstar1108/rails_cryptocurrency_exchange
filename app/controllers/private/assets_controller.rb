module Private
  class AssetsController < BaseController
    skip_before_action :auth_member!, only: [:index]

    def index
      @btc_assets  = Currency.assets('btc')
      @ltc_assets  = Currency.assets('ltc')
      @oct_assets  = Currency.assets('oct')
      @doge_assets  = Currency.assets('doge')
      @dsh_assets  = Currency.assets('dsh')
      # @xrp_assets  = Currency.assets('xrp')
      # @eth_assets  = Currency.assets('eth')
      # @bts_assets  = Currency.assets('bts')
      # @usdt_assets  = Currency.assets('usdt')
      # @dash_assets  = Currency.assets('dash')
      # @trmb_assets  = Currency.assets('trmb')
      # @xmr_assets  = Currency.assets('xmr')
      @rby_assets  = Currency.assets('rby')
      # @ybc_assets  = Currency.assets('ybc')
      # @xpm_assets  = Currency.assets('xpm')
      @gxc_assets  = Currency.assets('gxc')
      @ggc_assets  = Currency.assets('ggc')

      @btc_proof   = Proof.current :btc
      @ltc_proof   = Proof.current :ltc
      @oct_proof   = Proof.current :oct
      @doge_proof   = Proof.current :doge
      @dsh_proof   = Proof.current :dsh
      # @xrp_proof   = Proof.current :xrp
      # @eth_proof   = Proof.current :eth
      # @bts_proof   = Proof.current :bts
      # @usdt_proof   = Proof.current :usdt
      # @dash_proof   = Proof.current :dash
      # @trmb_proof   = Proof.current :trmb
      # @xmr_proof   = Proof.current :xmr
      @rby_proof   = Proof.current :rby
      # @ybc_proof   = Proof.current :ybc
      # @xpm_proof   = Proof.current :xpm
      @gxc_proof   = Proof.current :gxc
      @ggc_proof   = Proof.current :ggc

      if current_user
        @btc_account = current_user.accounts.with_currency(:btc).first
        # @cny_account = current_user.accounts.with_currency(:cny).first
        @ltc_account = current_user.accounts.with_currency(:ltc).first
        @oct_account = current_user.accounts.with_currency(:oct).first
        @doge_account = current_user.accounts.with_currency(:doge).first
        @dsh_account = current_user.accounts.with_currency(:dsh).first
        # @xrp_account = current_user.accounts.with_currency(:xrp).first
        # @eth_account = current_user.accounts.with_currency(:eth).first
        # @bts_account = current_user.accounts.with_currency(:bts).first
        # @usdt_account = current_user.accounts.with_currency(:usdt).first
        # @dash_account = current_user.accounts.with_currency(:dash).first
        # @trmb_account = current_user.accounts.with_currency(:trmb).first
        # @xmr_account = current_user.accounts.with_currency(:xmr).first
        @rby_account = current_user.accounts.with_currency(:rby).first
        # @ybc_account = current_user.accounts.with_currency(:ybc).first
        # @xpm_account = current_user.accounts.with_currency(:xpm).first
        @gxc_account = current_user.accounts.with_currency(:gxc).first
        @ggc_account = current_user.accounts.with_currency(:ggc).first
      end
    end

    def partial_tree
      account    = current_user.accounts.with_currency(params[:id]).first
      @timestamp = Proof.with_currency(params[:id]).last.timestamp
      @json      = account.partial_tree.to_json.html_safe
      respond_to do |format|
        format.js
      end
    end

  end
end
