class JournalEntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @journal_entries = current_user.journal_entries
  end

  def show
    @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def new
    @journal_entry = current_user.journal_entries.new
  end

  def create
    @journal_entry = current_user.journal_entries.new(journal_entry_params)
    if @journal_entry.save
      redirect_to @journal_entry, notice: 'Journal entry was successfully created.'
    else
      render :new
    end
  end

  def edit
    @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def update
    @journal_entry = current_user.journal_entries.find(params[:id])
    if @journal_entry.update(journal_entry_params)
      redirect_to @journal_entry, notice: 'Journal entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @journal_entry = current_user.journal_entries.find(params[:id])
    @journal_entry.destroy
    redirect_to journal_entries_url, notice: 'Journal entry was successfully destroyed.'
  end

  # New analyze action for journal entries
  def analyze
    openai_service = OpenaiService.new  # No arguments passed
    journal_entries = current_user.journal_entries.order(created_at: :asc)

    begin
      analysis = openai_service.analyze_journal_entries(journal_entries)
      render json: { analysis: analysis }
    rescue StandardError => e
      Rails.logger.error "An error occurred during analysis: #{e.message}"
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:content, :date)
  end

end
