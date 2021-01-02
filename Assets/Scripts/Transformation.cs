//=========================================
//Author: 洪金敏
//Email: jonny.hong91@gmail.com
//Create Date: 2021/01/02 23:44:08
//Description: 
//=========================================

using UnityEngine;

public abstract class Transformation : MonoBehaviour
{
	public abstract Vector3 Apply(Vector3 point);
}