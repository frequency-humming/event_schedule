class EventsController < ApplicationController


    def index
        @user = current_user
        @event = Event.where(state:@user.state)
        @events = Event.where.not(state:@user.state)
    end
    def create
        params[:event][:date] = Date.parse(params[:event][:date]).strftime("%Y-%m-%d") 
        event = Event.create(event_params)
        redirect_to "/events"
    end
    def show
        @event = Event.find(params[:id])
        @message = Message.where(event:params[:id])
        @attending = EventsAttending.where(event:params[:id])
    end
    def message
        Message.create(content:params[:content],user_id:current_user.id,event_id:params[:id])

        redirect_to "/events/#{ params[:id] }"
    end
    def join
        EventsAttending.create(user_id:current_user.id,event_id:params[:id])
        redirect_to "/events"
    end
    def destroy
        EventsAttending.find_by(user_id:current_user.id,event_id:params[:id]).destroy
        redirect_to "/events" 
    end
    def delete
        Event.find(params[:id]).destroy
        redirect_to "/events"
    end

    private
    def event_params
        params.require(:event).permit(:name, :date, :location, :state,:user_id)
    end

end
