package controllers

import play.api.mvc.{Controller, Action}

/**
 *
 * @author Peter Kolloch <kolloch@web-app-evolution.com>
 */
object Application extends Controller {
  def index = Action {
    Ok("test")
  }
}
