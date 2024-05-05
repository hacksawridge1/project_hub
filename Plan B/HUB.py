from model.model import Model
from view.view import View
from control.control import Control

if __name__ == "__main__":
    model = Model()
    view = View()
    control = Control(model, view)