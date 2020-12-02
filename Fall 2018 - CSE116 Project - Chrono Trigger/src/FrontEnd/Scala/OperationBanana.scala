package FrontEnd.Scala

import scalafx.application.JFXApp
import scalafx.application.JFXApp.PrimaryStage
import scalafx.scene.Scene
import scalafx.scene.layout.GridPane

object OperationBanana extends JFXApp {
  val game = new Placeholder()

  this.stage = new PrimaryStage{
    title = "CSE Students Play Chrono Trigger"
    scene = new Scene() {
      content = List(
        new GridPane {
          add(new ActionButton("Left", game), 0, 6)
          add(new ActionButton("Right", game), 2, 6)
          add(new ActionButton("Up", game), 1, 5)
          add(new ActionButton("Down", game), 1, 6)
          add(new ActionButton("A", game), 4, 6)
          add(new ActionButton("B", game), 5, 6)
        }
      )
    }
  }

}
