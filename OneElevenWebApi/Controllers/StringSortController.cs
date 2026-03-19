using Microsoft.AspNetCore.Mvc;

namespace OneElevenWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StringSortController : ControllerBase
    {
        

        [HttpPost]
        public IActionResult SortCharacters([FromBody] InputModel input)
        {
            if (input == null || string.IsNullOrEmpty(input.Data))
            {
                return BadRequest("Data field is required");
            }
            var characters = input.Data.ToCharArray();
            var sortedCharacters = characters.OrderBy(c => c).Select(c => c.ToString()).ToArray();
            return Ok(new { word = sortedCharacters });

        }
    }

    public class InputModel
    {
        public string Data { get; set; }
    }
}
