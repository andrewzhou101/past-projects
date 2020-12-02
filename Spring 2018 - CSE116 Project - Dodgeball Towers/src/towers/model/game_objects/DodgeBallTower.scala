package towers.model.game_objects

import play.api.libs.json.{JsValue, Json}
import towers.model.genetics.genes.Gene
import towers.model.physics.PhysicsVector

class DodgeBallTower(val x: Int, val y: Int) extends GameObject {

  // The height at which projectiles are fired
  val height = 3.0

  // Towers can only fire at players closer than this distance from the tower
  val sightRange = 5.0

  // The magnitude of the velocity at which projectiles are fired
  val projectileVelocity = 5.0


  def fire(jsonGameState: String): List[Projectile] = {
    val parsed: JsValue = Json.parse(jsonGameState)
    val players: List[Map[String, JsValue]] = parsed("players").as[List[Map[String, JsValue]]]

    var finalx: Double = 0
    var finaly: Double = 0
    var towerdistance: Double = 20000000

    for(kappa <- players){
        val valuex: Double = kappa("x").as[Double]
        val valuey: Double = kappa("y").as[Double]
        val valuedistance: Double = Math.sqrt(math.pow(x.toDouble + 0.5 - valuex, 2.0) + Math.pow(y.toDouble + 0.5 - valuey, 2.0))
        if(valuedistance < towerdistance){
          finalx = valuex
          finaly = valuey
          towerdistance = valuedistance
        }
      }
    if(towerdistance >= sightRange){
      return List()
    }

    val pewpewstart: PhysicsVector = new PhysicsVector(x + 0.5, y + 0.5, height)
    var pewpewend: PhysicsVector = new PhysicsVector(finalx - x - 0.5, finaly - y - 0.5)
    pewpewend = pewpewend.normal2d()
    pewpewend.x = pewpewend.x * projectileVelocity
    pewpewend.y = pewpewend.y * projectileVelocity
    val pewpew: Projectile = new Projectile(pewpewstart, pewpewend)


    return List(pewpew)
  }





  def aimFire(jsonGameState: String): List[Projectile] = {
    val parsed: JsValue = Json.parse(jsonGameState)
    val players: List[Map[String, JsValue]] = parsed("players").as[List[Map[String, JsValue]]]

    var finalx: Double = 0
    var finaly: Double = 0
    var finalvelx: Double = 0
    var finalvely: Double = 0
    var towerdistance: Double = 20000000

    for(kappa <- players){
      val valuex: Double = kappa("x").as[Double]
      val valuey: Double = kappa("y").as[Double]
      val valuedistance: Double = Math.sqrt(math.pow(x.toDouble + 0.5 - valuex, 2.0) + Math.pow(y.toDouble + 0.5 - valuey, 2.0))
      if(valuedistance < towerdistance){
        finalx = valuex
        finaly = valuey
        finalvelx = kappa("v_x").as[Double]
        finalvely = kappa("v_y").as[Double]
        towerdistance = valuedistance
      }
    }
    if(towerdistance >= sightRange){
      return List()
    }

    def findTime(px: Double, py: Double, vx: Double, vy: Double, speed: Double = projectileVelocity): Double = {
      val a: Double = speed * speed - (vx * vx + vy * vy)
      val b: Double = px * vx + py * vy
      val c: Double = px * px + py * py

      val quad: Double = b * b + a * c

      var t: Double = 0
      if(quad >= 0){
        t = (b + Math.sqrt(quad)) / a
        if (t < 0){
          t = 0
        }
      }
      return t
    }

    val playerasPO: PhysicalObject = new PhysicalObject(new PhysicsVector(finalx, finaly), new PhysicsVector(finalvelx, finalvely))
    val potential: PhysicsVector = towers.model.physics.Physics.computePotentialLocation(playerasPO, findTime(finalx - x - 0.5, finaly - y - 0.5, finalvelx, finalvely))



    val pewpewstart: PhysicsVector = new PhysicsVector(x + 0.5, y + 0.5, height)
    var pewpewend: PhysicsVector = new PhysicsVector(potential.x - x - 0.5, potential.y - y - 0.5)
    pewpewend = pewpewend.normal2d()
    pewpewend.x = (pewpewend.x)* projectileVelocity
    pewpewend.y = (pewpewend.y) * projectileVelocity
    val pewpew: Projectile = new Projectile(pewpewstart, pewpewend)


    return List(pewpew)
  }


  // Suggested Genetic Algorithm setup
  def getFitnessFunction(targetPlayer: Player): PhysicsVector => Double = {
    null
  }

  def vectorIncubator(genes: List[Gene]): PhysicsVector = {
    null
  }

}
