package FrontEnd.Scala

import scalafx.Includes._
import scalafx.event.ActionEvent
import scalafx.scene.control.Button

class ButtonGod(gameinfo: Placeholder, xScale: Double, yScale: Double) extends Button {
  minWidth = 100 * xScale
  minHeight = 100 * yScale
  style = "-fx-font: 12 ariel;"
}

class ActionButton(val actionKey: String, game: Placeholder, xScale: Double = 1.0, yScale: Double = 1.0) extends ButtonGod(game, xScale, yScale) {
  onAction = (event: ActionEvent) => game.useAction(actionKey)
  text = actionKey
  style = "-fx-font: 16 ariel"
}

