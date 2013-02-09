class DocumentsController < ApplicationController
	def index
		@documents = Document.all
	end

	def new
		respond_to do |format| 
			format.js
			format.html { render :action => "new" } 
		end
	end

	def destroy
		@document = Document.find(params[:id])
		@document.destroy
	end
end
